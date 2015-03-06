From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 06 Mar 2015 13:17:36 +0000
Subject: Re: [PATCH] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <1595394.zdJD8lWkjG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1528110.Mb5xiNU0rc@wasted.cogentembedded.com> <CACRpkdbMzGXeK6fX-h09-3F+jzxNLNsJwzLSeQrLT0MmJDRnWg@mail.gmail.com> <54F9A09D.7040909@cogentembedded.com>
In-Reply-To: <54F9A09D.7040909@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Sergei,

On Friday 06 March 2015 15:42:05 Sergei Shtylyov wrote:
> On 3/6/2015 1:43 PM, Linus Walleij wrote:
> >> The  pin array handled by sh_pfc_map_pins() may contain holes
> >> representing non- existing pins. We have to first count the valid pins
> >> in order to calculate the size  of the memory to be allocated, then to
> >> skip over the non-existing pins when  initializing the allocated arrays,
> >> and then to return the number of valid pins  from sh_pfc_map_pins()
> >> instead of 0 on success.
> >> 
> >> As we have to touch devm_kzalloc() calls anyway, use more fitting
> >> devm_kcalloc() instead which additionally checks the array size. And
> >> since PINMUX_TYPE_NONE is #define'd as 0, stop re-initializing already
> >> zeroed out 'pmx->configs' array.
> >> 
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> 
> >> ---
> >> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> >> repo. This patch should be applied before my R8A7794 PFC support patch
> >> and before Laurent's patches removing non-existent GPIOs for R8A779[01],
> >> otherwise they would cause the kernel  to hang while booting!
> > 
> > OK not applying this until ACKed by Laurent,
> > and in the meantime I'm taking the three applied R8A7794 patches
> > out of my tree again.
> 
> Thanks!
> 
> > Can you please send these depending patches as a series with this
> > patch as 1/4 and the three R8A7794 patches as 2,3,4/4? Thanks.
> 
> OK, will try to remember. But what about Lauren't 2 patches also
> dependent on this one?

If you don't mind, please also include them in your series.

-- 
Regards,

Laurent Pinchart

