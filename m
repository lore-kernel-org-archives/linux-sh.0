From: Peter De Schrijver <pdeschrijver@nvidia.com>
Date: Tue, 29 Nov 2011 06:46:30 +0000
Subject: Re: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
Message-Id: <20111129064630.GW19069@tbergstrom-lnx.Nvidia.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
In-Reply-To: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 03, 2011 at 06:00:44PM +0100, Peter De Schrijver wrote:
> This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested by
> Russel King. It also converts some platforms to the new model.
> 
> Peter De Schrijver (3):
>   ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
>   ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
>   ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO

Ping? What should we do with this?

Cheers,

Peter.
