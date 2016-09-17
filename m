From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 17 Sep 2016 02:28:38 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <4e9682c6-1851-a8c5-bcf5-e924aa14c914@roeck-us.net>
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
[ ... ]

>>> It would be useful to know what compiler version was used to build the
>>> kernel. I wouldn't be surprised if some are buggy.
>>>
>> 4.6.3 from kernel.org.
>
> That is utterly ancient and probaby very buggy. I would recommend 5.x+
> or at the very least 4.7 or 4.8.
>
I found a toolchain with 5.3.0, and using it the problem disappears. Oh well.
Sorry for the noise.

Guenter

