From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Sep 2015 05:08:28 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <CANqRtoQgVymDqv2c2jZEhrnWa4SHWxQgjiHcsVB59B8pBRrNUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
	<5464456.UnsMOS3MTx@avalon>
	<20150903204000.GB1574@katana>
	<CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
	<20150905073143.GA1616@katana>
	<CANqRtoRs=f=07B=HSLCVg5G4rnhxj6Heod+spYwxHiKFLZqFWg@mail.gmail.com>
	<20150908105356.GA15793@katana>
In-Reply-To: <20150908105356.GA15793@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>

Hi Wolfram,

On Tue, Sep 8, 2015 at 7:53 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Yes, now a HD-ready TV is hooked up. It should give you something over
>> EDID. Let me know when you're done and I'll move things back.
>
> 'No EDID data' says bootlog. Also, all 0 when reading that i2c client
> address afterwards. I don't see or sense anything suspicious with the
> I2C transfers itself from remote.

Did you use the DRM/KMS modetest program to display stuff on the HDMI
monitor? To trigger the error case you need to a couple of steps -
just booting the kernel does not trigger things. The EDID provided by
the HDMI monitor is read out by the HDMI encoder chip that in turn is
connected over I2C to the SoC. I believe the connection between the
HDMI monitor and the HDMI encoder chip works ok, but the bits between
the HDMI encoder chip and the I2C master on the SoCs may need some
more attention.

> And could you maybe install a local TFTP server on your next images? :)

This was done by Geert earlier. Lets discuss details over IRC!

Thanks,

/ magnus
