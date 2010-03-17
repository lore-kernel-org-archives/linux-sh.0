From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 03:29:27 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003162029o12a9ceaehaa858c7f54407ec3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Mar 16, 2010 at 9:32 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Tue, Mar 16, 2010 at 8:59 PM, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com> wrote:
>> 2) I have a 32 bus connected sh2a D0 do smc9118 D0 and sh2a D31 do smc91=
18
>> D31; do I need a software swap? ( I followed the schematics of rsk+ 7203=
 eva
>> board before to learn that for big endioan processors the designer needs=
 to
>> physically swap the bytes).
>
> I've added code to enable swap on upstream for the rsk7203. It was
> needed by big endian platforms.

Look here:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;hr4cfb944007b7f8d346523a7810b53a35921bc5

and here:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=833cc67c7722e35863c6aaee9df56b442ef957ae

> Please use a newer kernel if possible.

If you use the latest kernel then the fixes above are already included.

I recommend you to use the sh-2.6 git tree for development.

Thanks,

/ magnus
