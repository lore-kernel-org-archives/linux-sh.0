From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 06 Mar 2015 11:34:59 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <5341607.ysC4Tafd3h@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be> <CACRpkdbv8V2DY6DniY5fOaSQNkNZtZQ6G_hrm-vcG9cjFTSAEA@mail.gmail.com> <CAMuHMdVhD2e2Q9bTwu_r30AUCq4=-GzH=RWp2TFL7tXXz3prJA@mail.gmail.com>
In-Reply-To: <CAMuHMdVhD2e2Q9bTwu_r30AUCq4=-GzH=RWp2TFL7tXXz3prJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Geert,

On Friday 06 March 2015 12:26:57 Geert Uytterhoeven wrote:
> On Fri, Mar 6, 2015 at 11:48 AM, Linus Walleij wrote:
> > On Fri, Feb 27, 2015 at 6:38 PM, Geert Uytterhoeven wrote:
> >> Register and field widths are in the range 1..32. Storing them in the
> >> pinctrl data in (arrays of) unsigned long wastes space.
> >> 
> >> This decreases the size of a (32-bit) shmobile_defconfig kernel
> >> supporting 7 SoCs by 26460 bytes.
> >> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > This 2/4 is not ACKed so pausing application after 1/4.
> > 
> > Is 3,4/4 independent of this patch?
> 
> Unfortunately not, as there are contextual dependencies.
> 
> Laurent: Is 2/4 OK for you as-is? Your comments about the size of reg are
> not related to "Store register/field widths in u8 instead of unsigned long",
> and thus an area for future improvement.

As just stated in a different reply to this patch, if you change reg to a u32 
in a separate patch (maybe as a v2 of 3/4 ?),

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

for this patch.

-- 
Regards,

Laurent Pinchart

