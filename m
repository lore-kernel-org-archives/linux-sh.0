From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2015 08:35:45 +0000
Subject: Re: [PATCH/RFC 3/3] dmaengine: sudmac: Add missing address widths and directions
Message-Id: <CAMuHMdVKnaQNwtRm4fFh9apsrj3DhTEuNKTEtuX936s3OoCtBg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436529553-30571-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436529553-30571-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Mon, Jul 13, 2015 at 10:31 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> Shimoda-san, are these correct?
>
> Unfortunately, the buswitdh of SUDMAC is 1 only.

Thanks, I'll update the patch.

>> diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
>> index 31e681230e1894f2..7c4066503ce335f7 100644
>> --- a/drivers/dma/sh/sudmac.c
>> +++ b/drivers/dma/sh/sudmac.c
>> @@ -331,6 +331,8 @@ static const struct shdma_ops sudmac_shdma_ops = {
>>
>>  static int sudmac_probe(struct platform_device *pdev)
>>  {
>> +     const enum dma_slave_buswidth widths = DMA_SLAVE_BUSWIDTH_1_BYTE |
>> +             DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
