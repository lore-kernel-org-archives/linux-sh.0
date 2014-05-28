From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 May 2014 12:47:46 +0000
Subject: Re: [PATCH v4] pci-rcar-gen2: add device tree support
Message-Id: <7670579.laOqWDiO2F@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <201405200110.21914.sergei.shtylyov@cogentembedded.com> <20140528030418.GN11907@google.com>
In-Reply-To: <20140528030418.GN11907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, horms@verge.net.au, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org

On Tuesday 27 May 2014 21:04:18 Bjorn Helgaas wrote:
> [+cc Arnd]
> 
> On Tue, May 20, 2014 at 01:10:20AM +0400, Sergei Shtylyov wrote:
> > From: Ben Dooks <ben.dooks@codethink.co.uk>
> > 
> > Add device tree probing support to the 'pci-rcar-gen2' driver.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > [Sergei: numerous fixes/cleanups/additions]
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> I'd like to see an ack from Simon (since it changes pci-rcar-gen2.c) and
> Arnd (since he pointed out some issues with the devicetree binding).
> 

Yes, looks good to me now,

Acked-by: Arnd Bergmann <arnd@arndb.de>
