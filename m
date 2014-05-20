From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 20 May 2014 18:20:32 +0000
Subject: Re: [PATCH v2 0/3] Add R8A7791/Koelsch/Henninger board PCI DT support
Message-Id: <537B9CF0.8020000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 05/20/2014 01:48 AM, Sergei Shtylyov wrote:

>     Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-v3.15-rc5-20140517' tag. Here we add internal PCI support for
> the R8A7791-based Koelsch and Henninger boards for the sake of getting USB
> EHCI/OHCI working...

    Forgot to mention that it depends on the internal PCI bridge device tree 
support reposted just before these patches...

> [1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
> [2/3] ARM: shmobile: koelsch: enable internal PCI
> [3/3] ARM: shmobile: henninger: enable internal PCI

WBR, Sergei

