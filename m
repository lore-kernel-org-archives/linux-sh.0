From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Jan 2016 08:57:40 +0000
Subject: Re: [PATCH v3] media: soc_camera: rcar_vin: Add rcar fallback compatibility string
Message-Id: <CAMuHMdUFWdfHrpCwkuDUTmdBUNdt2d=QZ8hKBbh5CF9wnFdtRA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452707918-4321-1-git-send-email-ykaneko0929@gmail.com>
	<Pine.LNX.4.64.1601231834370.10701@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1601231834370.10701@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Guennadi,

On Sat, Jan 23, 2016 at 6:37 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Thu, 14 Jan 2016, Yoshihiro Kaneko wrote:
>> Add fallback compatibility string for R-Car Gen2 and Gen3, This is
>> in keeping with the fallback scheme being adopted wherever appropriate
>> for drivers for Renesas SoCs.
>>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is based on the for-4.6-1 branch of Guennadi's v4l-dvb tree.
>>
>> v3 [Yoshihiro Kaneko]
>> * rebased to for-4.6-1 branch of Guennadi's tree.
>>
>> v2 [Yoshihiro Kaneko]
>> * As suggested by Geert Uytterhoeven
>>   drivers/media/platform/soc_camera/rcar_vin.c:
>>     - The generic compatibility values are listed at the end of the
>>       rcar_vin_of_table[].
>>
>>  Documentation/devicetree/bindings/media/rcar_vin.txt | 8 +++++++-
>>  drivers/media/platform/soc_camera/rcar_vin.c         | 2 ++
>
> I might be wrong in this specific case, please, correct me someone, but
> doesn't Documentation/devicetree/bindings/submitting-patches.txt tell us
> to submit bindings patches separately from the drivers part?

I think that mostly applies to new bindings and new drivers.
For small updates (e.g. adding a new compatible value), these tend to be
submitted as a single patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
