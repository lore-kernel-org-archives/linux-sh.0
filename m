From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 12:36:39 +0000
Subject: Re: [PATCH 0/2] PM / shmobile: Rework adding devices to PM domains on SH7372 boards
Message-Id: <201208131436.39788.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201208131432.43768.rjw@sisk.pl>
In-Reply-To: <201208131432.43768.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, August 13, 2012, Rafael J. Wysocki wrote:
> Hi,
> 
> On SH7372 boards devices are added to PM domains through a series of
> rmobile_add_device_to_domain_td() or rmobile_add_device_to_domain() calls
> which is quite inefficient.  The following two patches change that the
> domain-device pairs information is stored in tables and fed to a separate
> initialization function.

I forgot to mention that the patches are on top of the current linux-next
branch of the linux-pm.git tree.

Thanks,
Rafael
