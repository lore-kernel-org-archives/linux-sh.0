From: Daniel Palmer <danieruru@gmail.com>
Date: Tue, 15 Jul 2014 02:08:48 +0000
Subject: Re: USB doesn't work on ecovec24
Message-Id: <CAO64nm4Y+=38AJ3hQ+p_LU3um9octsw3G3BMc8fGRRFh1DZK=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAO64nm4gSsfoCTW5m5W=UTQcLYzCFdTE+paD_S3t_wP2Qsn1YA@mail.gmail.com>
In-Reply-To: <CAO64nm4gSsfoCTW5m5W=UTQcLYzCFdTE+paD_S3t_wP2Qsn1YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Changing:

CLKDEV_ICK_ID("fck", "sh-cmt-16.0", &mstp_clks[HWBLK_CMT]),
to
CLKDEV_ICK_ID("fck", "sh-cmt-32.0", &mstp_clks[HWBLK_CMT]),

Makes that error go away. Doesn't seem actually change anything though. ;)
I have noticed a few other issues with the defconfig. Like it should
enable fixed regulators etc.
I'll probably put together a patch set that fixes these small issues
and updates the defconfig.
There are some problems with the SD card slots too.
The card mounts but resets itself after any activity.



On Mon, Jul 14, 2014 at 5:57 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Daniel
>
>> sh_cmt on the ecovec24 is also currently broken because of a similar
>> issue it seems:
>>
>> sh_cmt sh-cmt-32.0: cannot get clock
>> sh_cmt: probe of sh-cmt-32.0 failed with error -2
>
> Hmm...
>
> latest patch which exchanges cmt is
> 9b17e48cd4df4e129976c37660cf9ec644c66059
> (sh: Switch to new style CMT device)
>
> Anyway, as 1st step, can you please send USB clock fixup patches ?
> There is no SH maintainer today.
> So, you can use "To:"
>
>     Andrew Morton <akpm@linux-foundation.org>
