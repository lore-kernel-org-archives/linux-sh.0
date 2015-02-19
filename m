From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Feb 2015 10:39:25 +0000
Subject: Re: [PATCH/RFC 2/2] regulator: da9210: Add optional interrupt support
Message-Id: <CAMuHMdU+Q7M=2UaCDyUaxq8mzT9x6-tSh+OQJF4MBrFrz_fTuQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
	<1424175072-14643-2-git-send-email-geert+renesas@glider.be>
	<20150217140110.GV9110@finisterre.sirena.org.uk>
	<CAMuHMdXOFVZWn+u4wyz4Ro_kS_LaWc4Mwrq-XZU3dPpjmX2E3w@mail.gmail.com>
	<20150219103346.GE3198@finisterre.sirena.org.uk>
In-Reply-To: <20150219103346.GE3198-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Mark,

On Thu, Feb 19, 2015 at 11:33 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 17, 2015 at 03:18:40PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Feb 17, 2015 at 3:01 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, Feb 17, 2015 at 01:11:12PM +0100, Geert Uytterhoeven wrote:
>
>> >>   - Does there exist any regulator notifier event that corresponds to
>> >>     DA9210_E_VMAX?
>
>> > What does that mean, I might be able to tell you?  I guess it might be
>> > an over voltage event...
>
>> Possibly. There's no regulator notifier event for that yet, though.
>> Shall I add one?
>
> I'm wondering if it may be better to change the first notification to
> just a general "out of regulation" one, though the consequences of over
> voltage are usually different to under voltage if that is what's going
> on here.
>
>> Anyway, let's wait for confirmation from Dialog...
>
> I guess - is there really no indication in the datasheet?

-ENOENT

(I hope that's actually -EPROBE_DEFER, as I applied for datasheet access
last week ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
