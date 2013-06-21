From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 21 Jun 2013 08:19:51 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
Message-Id: <201306211019.52102.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 21 June 2013, Guennadi Liakhovetski wrote:
> My preference still lies with specific per-feature driver bindings like in 
> my original implementation. Adding compatible strings to every driver for 
> every new SoC seems an absolute no-go to me. But with per-feature driver 
> bindings you would have exactly the same problem: if you later add support 
> for a new feature to the driver, and that feature is present on older 
> SoCs, the only way to enable it would be to replace the DT.

That is the main problem with the per-feature listing, but less of
a problem if you list both the original part and the specific name of
the new one in the compatible string.

It's also not an either-or thing. For a number of features, having
flags makes most sense, in particular when the feature is not
a property of the IP block but of the way it is connected to the
rest of the SoC.

	Arnd
