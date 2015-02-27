From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Feb 2015 13:44:08 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
Message-Id: <2529709.qprrL8H0DB@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424931398.git.horms+renesas@verge.net.au>
 <2088679.zVJXCDlFW0@wuerfel>
 <CAMuHMdXU6xTNec=82wXuBqh68qt8Amc1mo2c7nGYKDQO=rqTKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXU6xTNec=82wXuBqh68qt8Amc1mo2c7nGYKDQO=rqTKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 27 February 2015 11:41:04 Geert Uytterhoeven wrote:
> > We must not introduce the user interface in one kernel and then change
> > it in the next one, so I'm cautious about taking the pull request in
> > the current form. Once we have agreed on what the contents of the sysfs
> > files should be, I can take the patches, and then we are free to move
> > the implementation later.
> 
> Currently machine contains e.g. "Koelsch", which is the name of the board,
> not of the SoC.
> 
> We can derive the SoC name from soc_id, e.g. 0x47 = "R-Car M2-W".
> 

Yes, I think that would be best.

	Arnd
