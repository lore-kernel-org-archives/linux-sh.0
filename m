From: "Kieran Bingham" <kieranbingham@gmail.com>
Date: Mon, 28 Jan 2008 11:22:57 +0000
Subject: Re: About sh7203 framebuffer driver.
Message-Id: <82bcfa4d0801280322hb720104gb950015b2037cc8e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801281105.03067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200801281105.03067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

I believe the rotate function on the LCDC changed the way it read the
pixels from memory.

I think it turned the display from a 320x240 to a 240x320 display.
Useful for setting up the LCD panel in a different orientation etc..

I don't think the hardware can be used to perform rotation of an
image. that poses questions like
 - how would it stretch the image.
or
 - would it crop the image?

You can play with changing this register setting on the fly while the
board is running using HEW and choosing View --> CPU --> IO from the
menu's.

This gives you a view of all the on chip peripherals and access to
their registers.

Cheers
--
Kieran


On 28/01/2008, Fabio Giovagnini <fabio.giovagnini@aurion-tech.com> wrote:
> Hi All,
> I read the source code of sh7203 framebuffer driver made I suppose by MCP
> Data.
> I had a question: Is it possible to tell the driver to rotate the image usign
> the LCDC native register instructions?
> If yes how? Do I need to implemnet an iocontrol funcrion or what is the way?
>
>
> --
> Fabio Giovagnini
>
> Aurion s.r.l.
> via degli orti 11,
> 40050 Funo di Argelato (BO)
> P.I e C.F.
> 00885711200
> Tel. +39.335.8350919
> Fax +39.051.8659009
>
> www.aurion-tech.com
>
> account telefono VoIP skype (www.skype.com):
> aurion.giovagnini
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
