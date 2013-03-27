From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 04:52:42 +0000
Subject: Re: [PATCH 00/03 v3] ARM: shmobile: r8a73a4 APE6EVM board support
Message-Id: <20130327045241.GB8426@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326141228.19958.93081.sendpatchset@w520>
In-Reply-To: <20130326141228.19958.93081.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 26, 2013 at 11:12:28PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a73a4 APE6EVM board support (V3)
> 
> [PATCH 01/03 v2] ARM: shmobile: APE6EVM base support
> [PATCH 02/03 v2] ARM: shmobile: APE6EVM PFC support
> [PATCH 03/03 v2] ARM: shmobile: APE6EVM LAN9220 support
> 
> This series is V3 of initial support for the APE6EVM board.
> 
> The APE6EVM board makes use of the r8a73a4 SoC and has a
> couple of different I/O devices on board, but with this
> series only support for the SCIFA0 UART and the Ethernet
> chip is included.
> 
> In the future support for more I/O devices will be added as
> incremental feature patches.
> 
> Changes since V2:
> - Use PINCTRL instead of function GPIOs.
> - Modify bootargs to enable DHCP and NFS root.
> - Now depends on r8a73a4 PFC V2
> 
> Changes since V1:
> - Went from single patch to series
> - Use ape6evm_add_standard_devices() to setup SoC devices and clocks
> - Use PFC to configure SCIFA0
> - Add Ethernet support including PFC support
> 
> For more details please see the individual patches.

Thanks Magnus,

I have no outstanding concerns with these patches.
Let me know if/when you would like them queued-up for v3.10.
