From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 17 Jan 2018 02:36:37 +0000
Subject: Re: [PATCH 00/13] replace print_symbol() with printk()-s
Message-Id: <20180117023637.GC423@jagdpanzerIV>
List-Id: <linux-sh.vger.kernel.org>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
 <20180105100300.j3svmcvvpfe2iows@pathway.suse.cz>
 <20180105102105.GB471@jagdpanzerIV>
 <20180105102538.GC471@jagdpanzerIV>
 <20180105144239.i3pc6npgmoi4ddln@pathway.suse.cz>
 <20180108020942.GB533@jagdpanzerIV>
 <20180116163301.lh76kvjheyobjgkp@pathway.suse.cz>
In-Reply-To: <20180116163301.lh76kvjheyobjgkp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On (01/16/18 17:33), Petr Mladek wrote:
[..]
> > JFI, the patch is in Linus's tree as of now (d0729bc6bee797fb).
>=20
> Great. I have pushed the patch that removes printk_symbol()
> into printk.git, branch for-4.16-print-symbol.
>=20
> Note that I have updated the commit message similar way
> like I did for the other commits. Especially I wanted
> to mention what it was obsoleted by. The message is:
>=20
>   kallsyms: remove print_symbol() function
>=20
>   No more print_symbol()/__print_symbol() users left, remove these
>   symbols.
>=20
>   It was a very old API that encouraged people use continuous lines.
>   It had been obsoleted by %pS format specifier in a normal printk()
>   call.
>=20
>=20
> See also
> https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit=
/?h=3Dfor-4.16-print-symbol&id=D2279c9d7f7db7f97567368bfc4539b3411adf8d

thanks!

	-ss
