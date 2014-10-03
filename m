From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Fri, 03 Oct 2014 08:53:39 +0000
Subject: Re: [PATCH 1/1] spi: Using Trigger number to transmit/receive data
Message-Id: <542E6413.7010300@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1412045974-6715-1-git-send-email-cm-hiep@jinso.co.jp>	<1412045974-6715-2-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdU3riiMHpYQ8VSjhBnoi9CAJgDHvbkWKwvgDQFefTmi9g@mail.gmail.com>
In-Reply-To: <CAMuHMdU3riiMHpYQ8VSjhBnoi9CAJgDHvbkWKwvgDQFefTmi9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>

Hi Geert-san

On 2014年10月01日 02:17, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Tue, Sep 30, 2014 at 4:59 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> In order to transmit and receive data when have 32 bytes of data that
>> ready has prepared on Transmit/Receive Buffer to transmit or receive.
>> Instead transmits/receives a byte data using Transmit/Receive Buffer
>> Data Triggering Number will improve the speed of transfer data.
>>
>> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> Thanks for your patch!
>
> Please CC linux-spi on SPI patches.
Thanks, I'll do it next time!


>>   static int qspi_transfer_out_in(struct rspi_data *rspi,
>>                                  struct spi_transfer *xfer)
>>   {
>>          qspi_receive_init(rspi);
>> -
>> -       return rspi_common_transfer(rspi, xfer);
>> +       return qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
>> +                                           xfer->rx_buf, xfer->len);
> So this will always use PIO mode, even if DMA is available?
Thanks, I am going to make a new version with a DMA support.


Best Regards,
Jinso/Cao Minh Hiep.

>>   }
>>
>>   static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
>> --
>> 1.9.1
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

