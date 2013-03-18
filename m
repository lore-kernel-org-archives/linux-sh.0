From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Mar 2013 14:32:19 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
Message-Id: <201303181432.20107.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130318143203.26687.98180.sendpatchset@w520>
 <20130318143231.26687.41252.sendpatchset@w520>
In-Reply-To: <20130318143231.26687.41252.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 18 March 2013, Magnus Damm wrote:
> Both platform devices and DT devices are added in this
> patch. The platform device versions are used to provide
> a static interrupt map configuration for board code
> written in C.

I had not noticed this part with the first version. Why is this required?
I thought you would always have the DTS in there, so that can be used to
provide the resources even for static platform devices.

	Arnd
