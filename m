From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 29 Jan 2014 09:07:03 +0000
Subject: Re: [PATCH RFC 2/2] ARM: shmobile: lager: Increase the size of ARM corehent DMA pool
Message-Id: <52E8C4B7.3010605@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 28/01/14 18:53, Valentine Barshak wrote:
> This increases the size of ARM coherent DMA pool to 4MB to
> avoid issues with DMA bounce for PCI DMA transfers.

Would it be easier to enable CMA support given that the DU
driver really needs it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
