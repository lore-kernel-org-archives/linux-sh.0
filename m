From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:35:36 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: Enable modules for Lager and Koelsch
Message-Id: <52E2EAB8.2040108@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390566231-18928-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390566231-18928-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/24/2014 04:23 PM, Valentine Barshak wrote:
> This enables modules and module versioning support
> in lager_defconfig and koelsch_defconfig

Module unloading should also be enabled.
I'll add it and re-spin in a bit.

Thanks,
Val.

>
> Valentine Barshak (2):
>    ARM: shmobile: lager: Enable modules in defconfig
>    ARM: shmobile: koelsch: Enable modules in defconfig
>
>   arch/arm/configs/koelsch_defconfig | 2 ++
>   arch/arm/configs/lager_defconfig   | 2 ++
>   2 files changed, 4 insertions(+)
>

