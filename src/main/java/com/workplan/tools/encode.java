// Decompiled by DJ v3.12.12.98 Copyright 2014 Atanas Neshkov  Date: 2018/7/12 15:00:56
// Home Page:  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) ansi 
// Source File Name:   encode.java

package com.workplan.tools;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class encode
{

    public encode()
    {
    }

    public static void main(String args1[])
    {
    }

    public static String encode(String url)
    {
        try
        {
            String encodeURL = URLEncoder.encode(url, "UTF-8");
            return encodeURL;
        }
        catch(UnsupportedEncodingException e)
        {
            return (new StringBuilder("Issue while encoding")).append(e.getMessage()).toString();
        }
    }

    public static String decode(String url)
    {
        try
        {
            String prevURL = "";
            String decodeURL;
            for(decodeURL = url; !prevURL.equals(decodeURL); decodeURL = URLDecoder.decode(decodeURL, "UTF-8"))
                prevURL = decodeURL;

            return decodeURL;
        }
        catch(UnsupportedEncodingException e)
        {
            return (new StringBuilder("Issue while decoding")).append(e.getMessage()).toString();
        }
    }
}
