From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Wed, 06 Jan 2016 01:36:42 +0000
Subject: Re: [PATCH v3 UPDATE 09/17] drivers: Initialize resource entry to zero
Message-Id: <4132474.rE6EsOfV8R@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1452028537-27365-1-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1452028537-27365-1-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alexandre.bounine@idt.com>, linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org

On Tuesday, January 05, 2016 02:15:37 PM Toshi Kani wrote:
> I/O resource descriptor, 'desc' in struct resource, needs to be
> initialized to zero by default.  Some drivers call kmalloc() to
> allocate a resource entry, but does not initialize it to zero by
> memset().  Change these drivers to call kzalloc(), instead.
> 
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Acked-by: Simon Horman <horms+renesas@verge.net.au> # sh
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI part.

