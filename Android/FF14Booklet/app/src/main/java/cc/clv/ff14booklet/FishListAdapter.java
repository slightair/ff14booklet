package cc.clv.ff14booklet;

import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

/**
 * Created by slightair on 2014/12/30.
 */
public class FishListAdapter extends RecyclerView.Adapter <FishListAdapter.ViewHolder> {
    private Context mContext;
    private FishDataSet mDataSet;

    public static class ViewHolder extends RecyclerView.ViewHolder {
        public ImageView mThumbnailView;
        public TextView mNameView;
        public TextView mItemLevelView;
        public TextView mPatchView;
        public TextView mTypeView;
        public Button mLinkButton;
        public TextView mCheckmarkView;

        public ViewHolder(View v) {
            super(v);

            mThumbnailView = (ImageView)v.findViewById(R.id.thumbnail_view);
            mNameView = (TextView)v.findViewById(R.id.name_view);
            mItemLevelView = (TextView)v.findViewById(R.id.item_level_view);
            mPatchView = (TextView)v.findViewById(R.id.patch_view);
            mTypeView = (TextView)v.findViewById(R.id.type_view);
            mLinkButton = (Button)v.findViewById(R.id.link_button);
            mCheckmarkView = (TextView)v.findViewById(R.id.checkmark_view);

            mLinkButton.setText(String.valueOf((char)0xe9cb));
            mCheckmarkView.setText(String.valueOf((char)0xea10));
        }
    }

    public FishListAdapter(Context context, FishDataSet dataSet) {
        mContext = context;
        mDataSet = dataSet;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.fish_list_item_view, parent, false);
        ViewHolder vh = new ViewHolder(v);

        Typeface typeFace = Typeface.createFromAsset(mContext.getAssets(), "fonts/IcoMoon-Free.ttf");
        vh.mLinkButton.setTypeface(typeFace);
        vh.mCheckmarkView.setTypeface(typeFace);

        return vh;
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        final FishInfo fishInfo = mDataSet.get(position);

        String thumbnailUrl = String.format("http://ff14angler.com/img/f%04d.png", fishInfo.getId());
        Picasso.with(mContext).load(thumbnailUrl).noFade().into(holder.mThumbnailView);

        holder.mNameView.setText(fishInfo.getName());
        holder.mItemLevelView.setText("ITEM Lv " + fishInfo.getItemLv() + " " + fishInfo.getLv());
        holder.mPatchView.setText(fishInfo.getPatch());

        Resources resources = mContext.getResources();
        String typeString;
        if (fishInfo.getType() == FishDataSet.FishTypes.SUPER_SPIRIT.ordinal()) {
            typeString = resources.getString(R.string.fish_type_super_spirit);
        } else if (fishInfo.getType() == FishDataSet.FishTypes.SPIRIT.ordinal()) {
            typeString = resources.getString(R.string.fish_type_spirit);
        } else {
            typeString = resources.getString(R.string.fish_type_normal);
        }
        holder.mTypeView.setText(typeString);

        holder.mLinkButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String pageUrl = "http://ff14angler.com/fish/" + fishInfo.getId();

                Intent intent = new Intent(mContext, WebViewActivity.class);
                intent.putExtra("page_url", pageUrl);
                intent.putExtra("fish_name", fishInfo.getName());
                mContext.startActivity(intent);
            }
        });

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TextView checkmarkView = (TextView) v.findViewById(R.id.checkmark_view);
                int visibility = checkmarkView.getVisibility() == View.VISIBLE ? View.INVISIBLE : View.VISIBLE;
                checkmarkView.setVisibility(visibility);
            }
        });
    }

    @Override
    public int getItemCount() {
        return mDataSet.size();
    }
}
