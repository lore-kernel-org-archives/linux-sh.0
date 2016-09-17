From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 17 Sep 2016 02:23:39 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <6bcec7af-9cbe-2fbe-8d53-fb9cb62fa21f@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916194532.GY2356@ZenIV.linux.org.uk>
 <20160916205938.GB29767@roeck-us.net>
 <20160916213141.GB2356@ZenIV.linux.org.uk>
 <20160916213918.GO15995@brightrain.aerifal.cx>
 <20160916224744.GB21916@roeck-us.net>
 <20160916233236.GU15995@brightrain.aerifal.cx>
In-Reply-To: <20160916233236.GU15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org

On 09/16/2016 04:32 PM, Rich Felker wrote:
>> 4.6.3 from kernel.org.
>
> That is utterly ancient and probaby very buggy. I would recommend 5.x+
> or at the very least 4.7 or 4.8.
>
Unfortunately that is the latest one available from kernel.org :-(.
I'll try to build one myself.

Thanks,
Guenter

