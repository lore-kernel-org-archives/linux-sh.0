From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Fri, 03 Jun 2011 13:42:09 +0000
Subject: Re: sh: fix wrong icache/dcache address-array start addr in cache-debugfs.
Message-Id: <4DE8E4B1.80809@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4DE76654.40605@st.com>
In-Reply-To: <4DE76654.40605@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,
My comments are in-lined.
Paul Mundt wrote:
> On Thu, Jun 02, 2011 at 11:30:44AM +0100, Srinivas KANDAGATLA wrote:
>> This patch fixes a icache/dcache address-array start address while
>> dumping its entires in debugfs. Perviously the code was attempting to
>> remember the address in static variable, which is no more required
>> for debugfs, as the function can be executed in one pass.
>>
> If the assertion that we can now do this in one pass is true then
> certainly killing of the complexity/brokenness of caching the array can
> be dropped. It's been many years since I wrote that code so I have
> absolutely no recollection of the re-entry case, but it was necessary at
> the time. 
Could be that, the existing code was carried from non-seq_file style 
interface (proc read...).
> Has something changed in debugfs or the seq file interface that
> I'm unaware of that suddenly makes everything doable in a single pass?
The seq_file interface, seq_read allocates sufficient buff memory to run 
show function in single pass.
>
> Also, what cache configurations have you tested this with? Our common
> case is 4-way set associative 32kB dcache, which if memory serves was
> already enough to overrun whatever debugfs had handy (I suppose a 4k
> page, as with procfs).
I did test on 2Way cache with 32KB icache/dcache system.
Original issue is not do with overrun, but incorrect results in virtual 
file.



Thanks,
srini

