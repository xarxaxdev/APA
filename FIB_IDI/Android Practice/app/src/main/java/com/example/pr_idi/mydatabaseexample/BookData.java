package com.example.pr_idi.mydatabaseexample;

/**
 * BookData
 * Created by pr_idi on 10/11/16.
 */
import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

public class BookData {

    // Database fields
    private SQLiteDatabase database;

    // Helper to manipulate table
    private MySQLiteHelper dbHelper;

    // Here we only select Title and Author, must select the appropriate columns
    private String[] allColumns = { MySQLiteHelper.COLUMN_ID,
            MySQLiteHelper.COLUMN_TITLE, MySQLiteHelper.COLUMN_AUTHOR};

    public BookData(Context context) {
        dbHelper = new MySQLiteHelper(context);
    }

    public void open() throws SQLException {
        database = dbHelper.getWritableDatabase();
    }

    public void close() {
        dbHelper.close();
    }

    public Book createBook(String title, String author) {
        ContentValues values = new ContentValues();
        Log.d("Creating", "Creating " + title + " " + author);

        // Add data: Note that this method only provides title and author
        // Must modify the method to add the full data
        values.put(MySQLiteHelper.COLUMN_TITLE, title);
        values.put(MySQLiteHelper.COLUMN_AUTHOR, author);

        // Invented data
        values.put(MySQLiteHelper.COLUMN_PUBLISHER, "Do not know");
        values.put(MySQLiteHelper.COLUMN_YEAR, 2030);
        values.put(MySQLiteHelper.COLUMN_CATEGORY, "Fantasia");
        values.put(MySQLiteHelper.COLUMN_PERSONAL_EVALUATION, "regular");

        // Actual insertion of the data using the values variable
        long insertId = database.insert(MySQLiteHelper.TABLE_BOOKS, null,
                values);

        // Main activity calls this procedure to create a new book
        // and uses the result to update the listview.
        // Therefore, we need to get the data from the database
        // (you can use this as a query example)
        // to feed the view.

        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,
                allColumns, MySQLiteHelper.COLUMN_ID + " = " + insertId, null,
                null, null, null);
        cursor.moveToFirst();
        Book newBook = cursorToBook(cursor);

        // Do not forget to close the cursor
        cursor.close();

        // Return the book
        return newBook;
    }

    public void deleteBook(Book book) {
        long id = book.getId();
        System.out.println("Book deleted with id: " + id);
        database.delete(MySQLiteHelper.TABLE_BOOKS, MySQLiteHelper.COLUMN_ID
                + " = " + id, null);
    }

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();

        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,
                allColumns, null, null, null, null, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            Book book = cursorToBook(cursor);
            books.add(book);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return books;
    }

    private Book cursorToBook(Cursor cursor) {
        Book book = new Book();
        book.setId(cursor.getLong(0));
        book.setTitle(cursor.getString(1));
        book.setAuthor(cursor.getString(2));
        return book;
    }

    public int modificaValoracio(String titol, String nova_valoracio) {
        open();
        String clause = MySQLiteHelper.COLUMN_TITLE + " = '" + titol + "'";
        ContentValues content = new ContentValues();
        content.put(MySQLiteHelper.COLUMN_PERSONAL_EVALUATION,nova_valoracio);
        int res = database.update(MySQLiteHelper.TABLE_BOOKS,content,clause,null);
        close();
        if (res == 0) return -1;
        return 0;
    }
    public int cercaTitol(String titol) {
        open();
        String clause = MySQLiteHelper.COLUMN_TITLE + " = '" + titol + "'";
        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,null,clause,null,null,null,null);
        int res;
        if (!cursor.moveToFirst()) res = -1;
        else res = 0;
        close();
        return res;
    }

    public int cercaAutor(String autor) {
        open();
        String clause = MySQLiteHelper.COLUMN_AUTHOR + " = '" + autor + "'";
        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,null,clause,null,null,null,null);
        int res;
        if (!cursor.moveToFirst()) res = -1;
        else res = 0;
        close();
        return res;
    }

    public String agafaValoracio(String titol) {
        open();
        String clause = MySQLiteHelper.COLUMN_TITLE + " = '" + titol + "'";
        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,null,clause,null,null,null,null);
        String res;
        if (cursor.moveToFirst())  res = cursor.getString(cursor.getColumnIndex(MySQLiteHelper.COLUMN_PERSONAL_EVALUATION));
        else res = "";
        close();
        return res;
    }

    public List<String> agafaLlibresAutor(String autor) {
        open();
        String clause = MySQLiteHelper.COLUMN_AUTHOR + " = '" + autor + "'";
        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,null,clause,null,null,null,null);
        List<String> res = new ArrayList<>();
        if (cursor.moveToFirst()) {
            do {
                res.add(cursor.getString(cursor.getColumnIndex(MySQLiteHelper.COLUMN_TITLE)));
            } while (cursor.moveToNext());
        }
        close();
        return res;
    }



    public List<String> agafaLlibres() {
        open();
        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,null,null,null,null,null,null);
        List<String> res = new ArrayList<>();
        if (cursor.moveToFirst()) {
            do {
                res.add(cursor.getString(cursor.getColumnIndex(MySQLiteHelper.COLUMN_TITLE)));
            } while (cursor.moveToNext());
        }
        close();
        return res;
    }

    public List<String> agafaAutors() {
        open();
        Cursor cursor = database.query(MySQLiteHelper.TABLE_BOOKS,null,null,null,null,null,null);
        List<String> res = new ArrayList<>();
        if (cursor.moveToFirst()) {
            do {
                res.add(cursor.getString(cursor.getColumnIndex(MySQLiteHelper.COLUMN_AUTHOR)));
            } while (cursor.moveToNext());
        }
        close();
        return res;
    }
}