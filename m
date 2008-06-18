From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Jun 2008 09:40:14 +0000
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
Message-Id: <20013.1213782014@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: dhowells@redhat.com, jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, gerg@uclinux.org, ralf@linux-mips.org, linux-mips@linux-mips.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

Adrian Bunk <bunk@kernel.org> wrote:

> This patch removes the unused pcibios_update_resource() functions the 
> kernel gained since.

Fine for FRV, since it's #if'd out anyway.

Acked-by: David Howells <dhowells@redhat.com>
