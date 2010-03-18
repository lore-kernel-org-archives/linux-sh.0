From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 18 Mar 2010 05:14:53 +0000
Subject: Re: nfsroot is to slow
Message-Id: <201003180614.54038.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

I solved specifing=20
nfsroot=192.168.1.2/home/fgiovagnini/nfsroot,v3,tcp

Cheers


In data gioved=EC 18 marzo 2010 01:25:35, Conrad Parker ha scritto:
: > On 18 March 2010 01:28, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi all,
> > now I'm able to mount root nfs but it is so slow:
> > /dev/root,0x0c1a58a0,0x00008000,0x0c24659c
> > do_mount_root,273 - debug 2
> > do_mount_root,277 - debug 3
> > do_mount_root,279 - debug 4
> > VFS: Mounted root (nfs filesystem).
> > Freeing unused kernel memory: 88k freed
> > nfs: server 192.168.1.2 not responding, still trying
> > nfs: server 192.168.1.2 OK
> > nfs: server 192.168.1.2 not responding, still trying
> > nfs: server 192.168.1.2 not responding, still trying
> >
> > I can see this.
> > Where can I investigate.
> > Server side or my board side?
>=20
> Is this with a current kernel?
>=20
> Conrad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
