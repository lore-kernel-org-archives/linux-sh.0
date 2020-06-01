From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 01 Jun 2020 08:15:02 +0000
Subject: Re: [PATCH] sh: fixup strncpy()
Message-Id: <2d4ac135-3fed-a526-daf5-81d3b51197ed@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8736dijdit.wl-kuninori.morimoto.gx@renesas.com>
 <87zhfqhyuf.wl-kuninori.morimoto.gx@renesas.com>
 <b1336fcf-8b04-e16c-420c-ed7e766fef12@physik.fu-berlin.de>
 <87eeqzzn4m.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eeqzzn4m.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Kuninori!

On 6/1/20 1:43 AM, Kuninori Morimoto wrote:
>> Since I don't want your fixes to fall off the table, you can ask Andrew
>> Morton to pick up your patches which is apparently the normal path to
>> choose when the original maintainers are currently not available.
> 
> Actually, I had been posted it to Andrew many times [1],
> but nothing happened.

Okay, that's unfortunate.

> And according to [2], it seems SH maintainers are still working,
> thus, normal path is still them.

Yes, Rich seems to be back on track.

> I had been worked for SH before, and posted many fixup patches
> for many times to both Andrew and SH maintainers.
> But their are still not yet reviewd/accepted.
> And unfortunately, it seems I'm judged as spam from SH maintainers [2].
> So I can do nothing anymore...

I really appreciate your help and I would like to see more of your fixes
come in. Please don't be let down and let's try to get your patches
merged.

Rich has promised that he will create a new tree on his website, so I think
your patches will be merged soon.

If you have more ideas for fixes, please feel encouraged to post patches, I
will try to help you to get all of them merged. I'm very sorry that you had
to wait for such a long time.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
