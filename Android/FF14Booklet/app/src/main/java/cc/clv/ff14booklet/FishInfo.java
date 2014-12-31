package cc.clv.ff14booklet;

import lombok.Value;

/**
 * Created by slightair on 2014/12/30.
 */
@Value
public class FishInfo {
    private final String name;
    private final String patch;
    private final String lv;
    private final String lodestone;
    private final int id;
    private final String itemLv;
    private final int type;
}
