package com.acbr.secondDisplay;

import android.app.Activity;
import android.app.Presentation;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.Display;
import android.view.View;
import android.util.Log;

public class SecondDisplayPresentation extends Presentation {
    
	private myView PresentationView; 

	public SecondDisplayPresentation(Context outerContext, Display display) {
		super(outerContext, display);
		PresentationView = new myView(outerContext);
		setContentView(PresentationView);
		}

	public View GetView()      
		{
		return this.PresentationView;
		}
	
	public void setBitmap(Bitmap aBitmap, int aX, int aY) {
		PresentationView.setBitmap(aBitmap, aX, aY);
		}
		
	private class myView extends View {
	
		private Bitmap BitmapView;
		private int X, Y;
	
		public myView(Context context) {
		super(context);
		}
 
		public void setBitmap(Bitmap aBitmap, int aX, int aY) {
			BitmapView = aBitmap;
			X = aX;
			Y = aY;
			invalidate();
			}
		
		@Override
		protected void onDraw(Canvas canvas) {
			if (BitmapView != null) {
				Paint myPaint = new Paint();
				canvas.drawBitmap(BitmapView, X, Y, myPaint); 
				}
			}
	}

}