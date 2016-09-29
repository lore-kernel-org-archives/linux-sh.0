From: Rob Landley <rob@landley.net>
Date: Thu, 29 Sep 2016 02:36:16 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <3d8e3da2-3de6-ac25-696c-8a64ae5e2df0@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916194532.GY2356@ZenIV.linux.org.uk>
 <20160916205938.GB29767@roeck-us.net>
 <20160916213141.GB2356@ZenIV.linux.org.uk>
 <20160916213918.GO15995@brightrain.aerifal.cx>
 <20160916224744.GB21916@roeck-us.net>
 <20160916233236.GU15995@brightrain.aerifal.cx>
 <6bcec7af-9cbe-2fbe-8d53-fb9cb62fa21f@roeck-us.net>
 <a94d1dff-fdba-bb36-b87e-34762ffc3e08@landley.net>
 <20160918151734.GA15995@brightrain.aerifal.cx>
In-Reply-To: <20160918151734.GA15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org

On 09/18/2016 10:17 AM, Rich Felker wrote:
> On Sat, Sep 17, 2016 at 11:40:28PM -0500, Rob Landley wrote:
>>
>>
>> On 09/16/2016 09:23 PM, Guenter Roeck wrote:
>>> On 09/16/2016 04:32 PM, Rich Felker wrote:
>>>>> 4.6.3 from kernel.org.
>>>>
>>>> That is utterly ancient and probaby very buggy. I would recommend 5.x+
>>>> or at the very least 4.7 or 4.8.
>>>>
>>> Unfortunately that is the latest one available from kernel.org :-(.
>>> I'll try to build one myself.
>>
>> Rich, you really, really need to get an actual release version of
>> https://github.com/richfelker/musl-cross-make posted.
> 
> What do you mean? Binaries? There are release tags, though it would
> probably be a good time to make another one.
> 
> But this project (musl-cross-make) is not needed for building kernels
> -- stock gcc, any modern-ish version, should work fine. The canonical
> way (from prior to my involvement) to build sh* kernels is to use a
> gcc that supports any ISA level, and this can be done without multilib
> libgcc since the kernel provides its own libgcc replacement functions.

The above was an example of somebody using a broken toolchain because
there isn't a known-good reference toolchain for the architecture, which
the kernel maintainer is known to regression test against. Having such a
thing might help people distinguish "bug in kernel" from "bug in gcc".

> Rich

Rob
