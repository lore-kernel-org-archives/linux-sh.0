From: Rob Landley <rob@landley.net>
Date: Fri, 27 Mar 2020 22:05:57 +0000
Subject: Re: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
Message-Id: <0f44cd31-a3e4-7b14-b9a8-28e4b0fd571e@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200315175108.9694-2-romain.naour@gmail.com>
In-Reply-To: <20200315175108.9694-2-romain.naour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org



On 3/26/20 3:42 PM, Rich Felker wrote:
> On Sun, Mar 15, 2020 at 06:51:08PM +0100, Romain Naour wrote:
>> Since the patch [1], building the kernel using a toolchain built with
>> Binutils 2.33.1 prevent booting a sh4 system under Qemu.
>> Apply the patch provided by Alan Modra [2] that fix alignment of rodata.
>>
>> [1] https://sourceware.org/git/gitweb.cgi?p=3Dbinutils-gdb.git;h=EBd2263=
ba9a9124d93bbc0ece63d7e0fae89b40e
>> [2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html
>>
>> Signed-off-by: Romain Naour <romain.naour@gmail.com>
>> Cc: Alan Modra <amodra@gmail.com>
>=20
> Acked-by: Rich Felker <dalias@libc.org>

Is there any way to get this into sunday's release?

Acked-by: Rob Landley <rob@landley.net>
