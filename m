From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 17 Jan 2018 21:17:55 +0000
Subject: Re: [PATCH v6 20/99] ida: Convert to XArray
Message-Id: <e8c42206-e4d7-dda3-2bb7-2c1faa6ff5be@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180117202203.19756-21-willy@infradead.org>
In-Reply-To: <20180117202203.19756-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Matthew!

On 01/17/2018 09:20 PM, Matthew Wilcox wrote:
> Use the xarray infrstructure like we used the radix tree infrastructure.
> This lets us get rid of idr_get_free() from the radix tree code.

There's a typo: infrstructure => infratructure

Cheers,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
