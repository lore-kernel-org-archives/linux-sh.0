From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 08 Jun 2009 08:16:56 +0000
Subject: Re: Hi all,long silence from me
Message-Id: <200906081016.56641.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200906041501.25421.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200906041501.25421.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Thanks a lot magnus.
I built the toolchan from codesourcery 4.3 stable and newlib-1.17 (the late=
st=20
version)
It seem to compile my code; now I have to work to test the functionalites.

I'll keep you informed if you like.

Best regards a nd thanks again

Alle 09:58, luned=EC 8 giugno 2009, Magnus Damm ha scritto:
> Hi Fabio,
>
> On Fri, Jun 5, 2009 at 9:42 PM, Fabio
>
> Giovagnini<fabio.giovagnini@aurion-tech.com> wrote:
> > I have downloaded the source code from your website.
> > I'm tring to build the toolchain step by step because I'd like to have
> > the sh2a instruction set support but also the smallest size of
> > applications; in fact I'm interested at this step to the toolchain for
> > compiling my own application framework being not an OS at all. I'm not
> > interested to run linux-sh at this step.
> > So I'd like to build the toolchain with newlib support or at most uclibc
> > support.
> > Wher could I find the any docs regarding these aspectcs?
> >
> > Thanks a lot
>
> I'm afraid that I have not seen any documentation in this area. You
> are of course free to browse the source for the codesourcery/kpit/ST
> tools and cherry pick patches, but I don't recommend it if you value
> your time. =3D)
>
> I spent a few days a year or two ago trying to cherry pick patches for
> sh4al-dsp and integrate in buildroot and/or crosstool, and at that
> point all I ended up with was a big mess. Things were far from good
> upstream back then, hopefully it's better today.
>
> Good luck! =3D)
>
> / magnus

--=20
Fabio Giovagnini

Aurion s.r.l.
Tel. +39.335.8350919

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
