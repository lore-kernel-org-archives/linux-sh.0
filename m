From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 28 Mar 2011 23:29:47 +0000
Subject: Re: [PATCH 2/2] sh: Add sh_io_port_base check in __ioport_map function
Message-Id: <AANLkTin428Y-uoseEm62wor5EJGN2wNB2GYANTKB6AVV@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2011/3/28 Daniel Palmer <me@danielpalmer.co.uk>:
> On 27/03/11 08:45, Nobuhiro Iwamatsu wrote:
>>
>> I think that this is other problem for pata_artop.
>> This patch fix calculation of address.
>>
>> Best regards,
>> =A0 Nobuhiro
>>
>
> With some advice from another Landisk/USL-5P user..
>
> Changing a line in arch/sh/kernel/ioport.c
>
> const unsigned long sh_io_port_base __read_mostly =3D 0xfe240000;
>
> Seems to fix PCI.
>
> All PCI seems to be broken in 2.6.38.
> Loading 8139cp for the ethernet controller makes the board hang.
>
> Also I have asked on the linux-ide list. PATA_ARTOP is working on other
> boards.

Thanks for your comments.
OK, I have LANDISK and USL-5P. I will check this problem.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
