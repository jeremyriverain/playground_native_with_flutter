package com.example.playgroundnative

import android.content.Context
import android.database.Cursor
import android.provider.ContactsContract

class ContactsService(private val context: Context) {
    fun fetchContacts(): List<String> {
        val contactsArray = mutableListOf<String>()
        val contentResolver = context.contentResolver
        val cursor: Cursor? = contentResolver.query(
            ContactsContract.Contacts.CONTENT_URI,
            null,
            null,
            null,
            null
        )

        cursor?.use {
            val displayNameIndex = it.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME)
            while (it.moveToNext()) {
                val displayName = if (displayNameIndex != -1) {
                    it.getString(displayNameIndex)
                } else {
                    null
                }
                displayName?.let { name -> contactsArray.add(name) }
            }
        }

        return contactsArray
    }
}