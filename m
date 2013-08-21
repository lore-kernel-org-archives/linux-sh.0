From: Thorsten Glaser <t.glaser@tarent.de>
Date: Wed, 21 Aug 2013 12:53:30 +0000
Subject: Re: [RFC] Get rid of SUBARCH
Message-Id: <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, 21 Aug 2013, Richard Weinberger wrote:

> The series touches also m68k, sh, mips and unicore32.
> These architectures magically select a cross compiler if ARCH !=3D SUBARC=
H.
> Do really need that behavior?

Not precisely that, but it=E2=80=99s very common in m68k land
to just cross-build kernels with

$ make ARCH=3Dm68k menuconfig
$ make ARCH=3Dm68k

Maybe a generalising of that feature, and making it
independent of SUBARCH (which can then die)?

bye,
//mirabilos
--=20
[16:04:33] bkix: "veni vidi violini"
[16:04:45] bkix: "ich kam, sah und vergeigte"...
