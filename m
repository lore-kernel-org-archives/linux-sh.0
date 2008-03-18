From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Mar 2008 03:20:14 +0000
Subject: Re: [HP6xx] - Detection of 16MB / 32MB - Questions
Message-Id: <20080318032014.GB3302@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080316172833.ce3dbc1d.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20080316172833.ce3dbc1d.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 16, 2008 at 05:28:33PM -0700, Kristoffer Ericson wrote:
> Currently we have 2 different configs for 16MB vs 32MB kernels since we cannot 
> use mem= as bootparam anymore. Was thinking to add some sort of detection code 
> for this inside the arch file.

You can't use mem= to _grow_ beyond CONFIG_MEMORY_SIZE, but you can
truncate. If you want to go that route, always build with
CONFIG_MEMORY_SIZE = 32MB and use mem= for the 16MB cases. We don't
support growing via mem= for a good reason, and dynamically growing from
a probe routine wouldn't avoid any of those issues.
