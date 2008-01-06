From: "Kieran Bingham" <kieranbingham@gmail.com>
Date: Sun, 06 Jan 2008 09:59:46 +0000
Subject: Re: Hi all, Happy new year!! This is my problem I cannot solve in a month.
Message-Id: <82bcfa4d0801060159u4dbaf3c8w9be53ee41f717c33@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801051105.24771.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200801051105.24771.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fabio,

The buildscripts that make the BSP also make the toolchain, - so you
could potentially look into adding C++ to the toolchain yourself.
I didn't look into it at the time, as I was on short timescales - and
only needed a c compiler.

I don't know what's involved in adding extra languages - but if you
look in the build folder, at Makefile.gcc-3.4.6 the configure line is
in there.
Looking at it, it could be as simple as changing the line

--enable-languages="c"
to
--enable-languages="c,c++"

I have no idea if it will be that simple or if you will hit any problems -

change the build script
type make distclean (important as the scripts won't know to rebuild
the toolchain)
then make

And let us know how it goes - if it works with no problems I'll try to
ensure that c++ is enabled by default in the future.
--
Kieran Bingham

On 05/01/2008, Fabio Giovagnini <fabio.giovagnini@aurion-tech.com> wrote:
> Hi,
> I'd like to run qt embedded on my sh2a 7203  eva board.
> MCP data gave me with the board the uClinux tree working with the BSP working
> properly; but in the tool chain there is only gcc and not g++ so I cannot try
> to  build qt embedded.
> I'd like to keep in place the tree from MCP data because of it has the BSP
> properly configured and workign so I do not stend time to do the same from
> scratch, btu I would only replase teh toolchain;
> How could I procede?
>
> Thanks a lot.
> na d Best Regards
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
