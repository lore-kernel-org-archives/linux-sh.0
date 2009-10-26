From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 26 Oct 2009 11:23:57 +0000
Subject: Re: [PATCH] sh: rsk7203 CONFIG_MTD=n fix
Message-Id: <200910261223.57648.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

OK. Thanks a lot.
Did you build any application for rsk7203?
I used MCP data environment, but it is without g++, so I cannot use librari=
es=20
as SDL, qt embedded, or more.
I think  exculding all the g++ stuff  is not strategic.



Alle 11:56, luned=EC 26 ottobre 2009, Magnus Damm ha scritto:
> Hey Fabio,
>
> On Mon, Oct 26, 2009 at 7:23 PM, Fabio Giovagnini
>
> <fabio.giovagnini@aurion-tech.com> wrote:
> > just in these days I'm designing a new custom borad derived from rsk720=
3.
> > I'd like to use linux-sh instead of uc-linux.
> > What toolchain should I use?
>
> Try the latest codesourcery toolchain. I use that for kernel
> development. For user space I'm not sure.
>
> > Where can I find the git user manual
>
> Good question. I suspect that there are a wide range of documents
> available for git, but I don't think I'm the right person to give any
> advice about that.
>
> Cheers,
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Fabio Giovagnini

Aurion s.r.l.
CF e P.IVA 00885711200
Tel. +39.335.8350919

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
