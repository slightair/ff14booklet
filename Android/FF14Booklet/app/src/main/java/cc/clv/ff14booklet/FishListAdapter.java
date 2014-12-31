package cc.clv.ff14booklet;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.TextView;

/**
 * Created by slightair on 2014/12/30.
 */
public class FishListAdapter extends RecyclerView.Adapter <FishListAdapter.ViewHolder> {
    private FishDataSet mDataset;

    public static class ViewHolder extends RecyclerView.ViewHolder {
        public TextView mTextView;
        public ViewHolder(TextView v) {
            super(v);
            mTextView = v;
        }
    }

    public FishListAdapter(FishDataSet dataset) {
        mDataset = dataset;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        TextView v = (TextView)LayoutInflater.from(parent.getContext()).inflate(R.layout.fish_list_item_view, parent, false);
        ViewHolder vh = new ViewHolder(v);

        return vh;
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        FishInfo fishInfo = mDataset.get(position);
        holder.mTextView.setText(fishInfo.getName());
    }

    @Override
    public int getItemCount() {
        return mDataset.size();
    }
}
