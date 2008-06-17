From: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 17 Jun 2008 12:54:21 +0000
Subject: Re: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Message-Id: <1213707261.26255.1038.camel@pmac.infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1213604973-7073-1-git-send-email-jacmet@sunsite.dk>
	 <1213617663.26255.708.camel@pmac.infradead.org>
	 <20080616121727.GB10854@cs181133002.pp.htv.fi>
	 <1213619214.26255.721.camel@pmac.infradead.org>
	 <20080617084235.GA20169@cs181133002.pp.htv.fi>
	 <1213696004.26255.960.camel@pmac.infradead.org>
	 <20080617101112.GE20169@cs181133002.pp.htv.fi>
	 <1213702113.26255.996.camel@pmac.infradead.org>
	 <20080617122346.GA10598@uranus.ravnborg.org>
	 <1213705749.26255.1027.camel@pmac.infradead.org>
	 <20080617123717.GC10598@uranus.ravnborg.org>
In-Reply-To: <20080617123717.GC10598@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@kernel.org>, Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, matthew@wil.cx, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2008-06-17 at 14:37 +0200, Sam Ravnborg wrote:
> I know and I know.
> If someone did the janitorial effort and converted all the
> per-arch defined symbols to one single definiton
> and select the list would grow rapidly.

http://git.infradead.org/users/dwmw2/aout-2.6.git?a=3Dcommitdiff;h=E75fd00c

They're still not in alphabetical order, but I haven't made it worse :)

--=20
dwmw2

