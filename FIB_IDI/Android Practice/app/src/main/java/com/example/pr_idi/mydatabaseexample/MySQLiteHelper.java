package com.example.pr_idi.mydatabaseexample;


import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class MySQLiteHelper extends SQLiteOpenHelper {

    public static final String TABLE_BOOKS = "books";
    public static final String COLUMN_ID = "_id";
    public static final String COLUMN_TITLE = "title";
    public static final String COLUMN_AUTHOR = "author";
    public static final String COLUMN_YEAR = "year";
    public static final String COLUMN_PUBLISHER = "publisher";
    public static final String COLUMN_CATEGORY = "category";
    public static final String COLUMN_PERSONAL_EVALUATION = "personal_evaluation";


    private static final String DATABASE_NAME = "books.db";
    private static final int DATABASE_VERSION = 1;

    // Database creation sql statement
    private static final String DATABASE_CREATE = "create table " + TABLE_BOOKS + "( "
            + COLUMN_ID + " integer primary key autoincrement, "
            + COLUMN_TITLE + " text not null, "
            + COLUMN_AUTHOR + " text not null, "
            + COLUMN_YEAR + " integer, "
            + COLUMN_PUBLISHER + " text not null, "
            + COLUMN_CATEGORY + " text not null, "
            + COLUMN_PERSONAL_EVALUATION + " text"
            + ");";

    public MySQLiteHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase database) {
        database.execSQL(DATABASE_CREATE);
        InsertLlibres(database);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        Log.w(MySQLiteHelper.class.getName(),
                "Upgrading database from version " + oldVersion + " to "
                        + newVersion + ", which will destroy all old data");
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_BOOKS);
        onCreate(db);
    }

    void InsertLlibres(SQLiteDatabase database) {
        ContentValues llibre1, llibre2, llibre3, llibre4;
        llibre1 = new ContentValues();
        llibre2 = new ContentValues();
        llibre3 = new ContentValues();
        llibre4 = new ContentValues();
        llibre1.put(COLUMN_TITLE, "The Lord Of The Rings");
        llibre1.put(COLUMN_AUTHOR, "J.R.R.Tolkien");
        llibre1.put(COLUMN_YEAR, 1950);
        llibre1.put(COLUMN_PUBLISHER, "minotauro");
        llibre1.put(COLUMN_CATEGORY, "Fantasia");
        llibre1.put(COLUMN_PERSONAL_EVALUATION, "regular");
        llibre2.put(COLUMN_TITLE, "Harry Potter");
        llibre2.put(COLUMN_AUTHOR, "J.K.Rowling");
        llibre2.put(COLUMN_YEAR, 1995);
        llibre2.put(COLUMN_PUBLISHER, "Salamanca");
        llibre2.put(COLUMN_CATEGORY, "Fantasia");
        llibre2.put(COLUMN_PERSONAL_EVALUATION, "molt bo");
        llibre3.put(COLUMN_TITLE, "Pirates Of The Caribbean");
        llibre3.put(COLUMN_AUTHOR, "Disney");
        llibre3.put(COLUMN_YEAR, 2000);
        llibre3.put(COLUMN_PUBLISHER, "Rob Kid");
        llibre3.put(COLUMN_CATEGORY, "Fantasia");
        llibre3.put(COLUMN_PERSONAL_EVALUATION, "molt bo");
        llibre4.put(COLUMN_TITLE, "Star Wars");
        llibre4.put(COLUMN_AUTHOR, "George Lucas");
        llibre4.put(COLUMN_YEAR, 1970);
        llibre4.put(COLUMN_PUBLISHER, "DK");
        llibre4.put(COLUMN_CATEGORY, "Fantasia");
        llibre4.put(COLUMN_PERSONAL_EVALUATION, "molt bo");
        database.insert(TABLE_BOOKS, null, llibre1);
        database.insert(TABLE_BOOKS, null, llibre2);
        database.insert(TABLE_BOOKS, null, llibre3);
        database.insert(TABLE_BOOKS, null, llibre4);
    }

}
