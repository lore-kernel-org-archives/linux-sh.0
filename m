From: Kevin Hilman <khilman@ti.com>
Date: Thu, 22 Sep 2011 19:45:32 +0000
Subject: Re: [RFC PATCH V6 0/4] cpuidle: Global registration of idle states with per-cpu statistics
Message-Id: <87ty84tl7n.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
In-Reply-To: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
	(Deepthi Dharwar's message of "Thu, 22 Sep 2011 13:58:52 +0530")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: venki@google.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, santosh.shilimkar@ti.com, arjan@linux.intel.com, lenb@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Deepthi Dharwar <deepthi@linux.vnet.ibm.com> writes:

> The following patch series implements global registration of cpuidle
> states, and also has the necessary data structure changes to
> accommodate the per-cpu writable members of the cpuidle_states
> structure.

I reviewed earlier versions of the series, and this version still looks
good to me.  Any reason it is still RFC?

Reviewed-by: Kevin Hilman <khilman@ti.com>

and for the OMAP-specific parts,

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin
