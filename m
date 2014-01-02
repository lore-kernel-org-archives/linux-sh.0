From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 02 Jan 2014 10:47:00 +0000
Subject: Re: [PATCH 4/8] spi: rspi: Add support for 8-bit Data Register access
Message-Id: <CAMuHMdW+nohaxWbWW=Sxd5DPQ1U=3v7w9NQd88MKTdk5Sjg_sw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
	<1387885248-28425-5-git-send-email-geert+renesas@linux-m68k.org>
	<13614197.Z9gKDhB8kb@avalon>
In-Reply-To: <13614197.Z9gKDhB8kb@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Laurent,

On Tue, Dec 31, 2013 at 12:47 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 24 December 2013 12:40:44 Geert Uytterhoeven wrote:
>> +static void rspi_write_data(const struct rspi_data *rspi, u16 data)
>> +{
>> +     if (rspi->data_width = 8)
>> +             rspi_write8(rspi, data, RSPI_SPDR);
>> +     else if (rspi->data_width = 16)
>> +             rspi_write16(rspi, data, RSPI_SPDR);
>
> As the driver only handles 8-bits and 16-bits data, replacing the else if with
> an else should be more efficient.

Sure, will add a comment "/* 16 bit only */", though.

>> +static int rspi_parse_platform_data(struct rspi_data *rspi,
>> +                                 const struct rspi_plat_data *rspi_pd)
>> +{
>> +     if (rspi_pd && rspi_pd->data_width) {
>> +             rspi->data_width = rspi_pd->data_width;
>> +             switch (rspi_pd->data_width) {
>> +             case 8:
>> +                     rspi->spdcr = SPDCR_SPLBYTE;
>> +                     break;
>> +             case 16:
>> +                     rspi->spdcr = SPDCR_SPLWORD;
>> +                     break;
>> +             default:
>> +                     return -1;
>
> Shouldn't you return a defined error code (-EINVAL maybe) ?

Sure.

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
