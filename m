From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 31 Oct 2014 09:56:39 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <CAO3366yn4KjF=qTYY+amJVCNhjGgCTi8AVzJu6Mi1+fVujsRVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Oct 30, 2014 at 7:03 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> I don't have the schematics for kzm9g, but I guess the LAN controller
> is hooked up to the BSC (Bus State Controller). According to the sh73a0
> datasheet, ZB=C3=B8 is the clock for the BSC.

Yes, I remember something like that. (Please ignore my previous
ramblings, I was looking at the APE6EVM schematics...)

CU
Uli
