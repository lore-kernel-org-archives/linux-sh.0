From: David Miller <davem@davemloft.net>
Date: Mon, 26 Mar 2018 16:34:47 +0000
Subject: Re: [PATCH 0/2] sh_eth: unify the SoC feature checks
Message-Id: <20180326.123447.1350791578528691423.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
In-Reply-To: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 24 Mar 2018 23:04:53 +0300

> Here's a set of 5 patches against DaveM's 'net-next.git' repo.
> 
> The Ether driver sometimes uses the bit fields in 'struct sh_eth_cpu_data'
> to check which Ether registers exist in a certain SoC and sometimes it uses
> sh_eth_is_{gether|rz_fast_ether}() which basically compares 2 pointers (1 of
> them being constant) -- the latter is definitely not a strongest feature of
> the RISC CPUs (be it SH or ARM), so I decided to get rid of this type of
> the feature checks in favour of the bit fields (I've also made use of a
> 32-bit value and method pointer where appropriate)...

Series applied with patch #4 subject fixed up.

Thank you.
