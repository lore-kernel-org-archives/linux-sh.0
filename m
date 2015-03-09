From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 09 Mar 2015 17:11:35 +0000
Subject: Re: [PATCH] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <CACRpkdZ_VHAnOqJV4Kpn1n_YZyVLKXEn4=tN=Ta=xrsMxq7Leg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1528110.Mb5xiNU0rc@wasted.cogentembedded.com>
	<CACRpkdbMzGXeK6fX-h09-3F+jzxNLNsJwzLSeQrLT0MmJDRnWg@mail.gmail.com>
	<1498074.6jEVhizFNe@avalon>
In-Reply-To: <1498074.6jEVhizFNe@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Mar 6, 2015 at 11:58 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Linus,
>
> On Friday 06 March 2015 11:43:45 Linus Walleij wrote:
>> On Sat, Feb 28, 2015 at 12:39 AM, Sergei Shtylyov wrote:
>> > The  pin array handled by sh_pfc_map_pins() may contain holes representing
>> > non- existing pins. We have to first count the valid pins in order to
>> > calculate the size  of the memory to be allocated, then to skip over the
>> > non-existing pins when  initializing the allocated arrays, and then to
>> > return the number of valid pins  from sh_pfc_map_pins() instead of 0 on
>> > success.
>> >
>> > As we have to touch devm_kzalloc() calls anyway, use more fitting
>> > devm_kcalloc() instead which additionally checks the array size. And
>> > since PINMUX_TYPE_NONE is #define'd as 0, stop re-initializing already
>> > zeroed out 'pmx->configs' array.
>> >
>> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> >
>> > ---
>> > The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
>> > repo. This patch should be applied before my R8A7794 PFC support patch
>> > and before Laurent's patches removing non-existent GPIOs for R8A779[01],
>> > otherwise they would cause the kernel  to hang while booting!
>>
>> OK not applying this until ACKed by Laurent,
>> and in the meantime I'm taking the three applied R8A7794 patches
>> out of my tree again.
>
> Could you also drop "pinctrl: sh-pfc: r8a7790: Remove non existing GPIO pins"
> and "pinctrl: sh-pfc: r8a7791: Remove non existing GPIO pins" for the same
> reason ? Sorry for the trouble.

OK dropped them (rebased .... argh hope noone will kick my ass)

Yours,
Linus Walleij
