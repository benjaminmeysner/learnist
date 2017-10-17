package FDMWebApp.aws;

import FDMWebApp.domain.Lesson;
import FDMWebApp.transfer_objects.CourseFile;
import FDMWebApp.transfer_objects.LessonFile;
import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by Rusty on 06/03/2017.
 */
@Component
public class StorageHandler {

	private static String config = System.getProperty("name");

	private static String bucketName = "learnist";

	public static String getUrlPrefix() {
		return "https://s3.eu-west-2.amazonaws.com/" + bucketName + "/" + config + "/";
	}

	public static String getDefaultCourseImage() {
		return "https://s3.eu-west-2.amazonaws.com/learnist/" + bucketName + "/course/course.png";
	}

	public static void upload(File file, String keyName) throws IOException {
		AmazonS3 s3client = new AmazonS3Client(
				new BasicAWSCredentials("AKIAJM23R4ZKUEXR4H2A", "gUKewBFm1fFSECWUBykXTwYvYunrsdM0ReisgwOh"));
		try {
			System.out.println("Uploading a new object to S3 from a file\n");
			s3client.putObject(new PutObjectRequest(bucketName, config + "/" + keyName, file));

		} catch (AmazonServiceException ase) {
			System.out.println("Caught an AmazonServiceException, which " + "means your request made it "
					+ "to Amazon S3, but was rejected with an error response" + " for some reason.");
			System.out.println("Error Message:    " + ase.getMessage());
			System.out.println("HTTP Status Code: " + ase.getStatusCode());
			System.out.println("AWS Error Code:   " + ase.getErrorCode());
			System.out.println("Error Type:       " + ase.getErrorType());
			System.out.println("Request ID:       " + ase.getRequestId());
		} catch (AmazonClientException ace) {
			System.out.println("Caught an AmazonClientException, which " + "means the client encountered "
					+ "an internal error while trying to " + "communicate with S3, "
					+ "such as not being able to access the network.");
			System.out.println("Error Message: " + ace.getMessage());
		}
	}

	public static String uploadCourseImage(CourseFile courseFile) throws Exception {
		String extension = getFileExtension(courseFile.getFile().getOriginalFilename());
		File file = File.createTempFile("course-image", extension);
		FileOutputStream fs = new FileOutputStream(file);
		fs.write(courseFile.getFile().getBytes());
		fs.close();
		String url = "course/" + courseFile.getCourse().getCode() + "/course-image" + extension;
		StorageHandler.upload(file, url);
		return getUrlPrefix() + url;
	}

	public static String getUrl(LessonFile lessonFile, boolean main) {
		String extension = getFileExtension(lessonFile.getFile().getOriginalFilename());
		String url;
		Lesson lesson = lessonFile.getLesson();
		if (main) {
			url = "course/" + lesson.getCourse().getCode() + "/" + lesson.getOrder() + "/main" + extension;
		} else {
			url = "course/" + lesson.getCourse().getCode() + "/" + lesson.getOrder() + "/"
					+ lessonFile.getFile().getOriginalFilename();
		}
		return getUrlPrefix() + url;
	}

	public static void uploadLessonFile(LessonFile lessonFile, boolean main) throws Exception {
		String extension = getFileExtension(lessonFile.getFile().getOriginalFilename());
		File file = File.createTempFile(lessonFile.getFile().getName(), extension);
		FileOutputStream fs = new FileOutputStream(file);
		fs.write(lessonFile.getFile().getBytes());
		fs.close();
		String url;
		Lesson lesson = lessonFile.getLesson();
		if (main) {
			url = "course/" + lesson.getCourse().getCode() + "/" + lesson.getOrder() + "/main" + extension;
		} else {
			url = "course/" + lesson.getCourse().getCode() + "/" + lesson.getOrder() + "/"
					+ lessonFile.getFile().getOriginalFilename();
		}
		StorageHandler.upload(file, url);
	}

	public static String getFileExtension(String filename) {
		int i = filename.lastIndexOf('.');
		if (i > 0) {
			return filename.substring(i);
		} else {

			return "";
		}
	}

	public static boolean isValidFile(MultipartFile file) {
		String filetype = file.getContentType();
		return (filetype.contains("text") || filetype.contains("image") || filetype.contains("pdf"));
	}

}
