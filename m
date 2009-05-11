From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 11 May 2009 07:34:21 +0000
Subject: Re: [PATCH] sh: clock framework update, fix count and kill off kref
Message-Id: <4A07D4FD.8060008@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul
Few days ago I had a discussion with Magnus on the current status of the 
clock framework
and both we agree to change how the .init call back should work.

The design I have in mind is:
 - the .init callback should be called during the clk_registration and
   if the init fails the clock framework rejects the clock.
 - Any operations with (CLK_NEEDS_INIT)  has to be managed internally to
   the clock-SOC implementation via archflag (or a void* private_data) 
to hive any
   implementation issue at clock framework level.

Magnus, Do you want add anything?
Paul, Do you have some issue on this design?

Regards
 Francesco


Paul Mundt ha scritto:
> On Fri, May 08, 2009 at 05:23:29PM +0900, Magnus Damm wrote:
>   
>> This patch updates the clock framework use count code.
>> With this patch the enable() and disable() callbacks
>> only get called when counting from and to zero.
>> While at it the kref stuff gets replaced with an int.
>>     

