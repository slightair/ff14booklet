package cc.clv.ff14booklet;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.util.ArrayList;

/**
 * Created by slightair on 2014/12/30.
 */
public class FishDataSet {
    private ArrayList<FishInfo> fishList;

    public static enum FishTypes {
        NORMAL,
        SPIRIT,
        SUPER_SPIRIT;
    }

    public FishDataSet(Context context) {
        Gson gson = new Gson();
        InputStream inputStream = context.getResources().openRawResource(R.raw.fish);

        JsonReader reader = new JsonReader(new InputStreamReader(inputStream));
        Type fishInfoType = new TypeToken<FishInfo>(){}.getType();

        this.fishList = new ArrayList<>();

        try {
            reader.beginArray();
            while (reader.hasNext()) {
                FishInfo fishInfo = gson.fromJson(reader, fishInfoType);
                this.fishList.add(fishInfo);
            }
            reader.endArray();
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public FishInfo get(int index) {
        return this.fishList.get(index);
    }

    public int size(){
        return this.fishList.size();
    }
}
