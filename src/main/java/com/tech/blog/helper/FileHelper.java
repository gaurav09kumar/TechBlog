package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class FileHelper {
	public static boolean deleteFile(String path) {
		boolean fileDeleted = false;
		try {
			File file = new File(path);
			fileDeleted = file.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileDeleted;
	}

	public static boolean saveFile(InputStream is, String path) {
		boolean fileSaved = false;
		try {
			byte b[] = new byte[is.available()];
			is.read(b);

			// write the data in the path
			FileOutputStream fos = new FileOutputStream(path);

			fos.write(b);

			fos.flush();

			fos.close();

			fileSaved = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileSaved;
	}
}
