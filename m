From: Chen Gang <gang.chen@asianux.com>
Date: Fri, 02 Aug 2013 04:01:12 +0000
Subject: Re: [PATCH] scripts/mod/modpost.c: permit '.cranges' secton for sh64 architecture.
Message-Id: <51FB2F08.5010600@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51F9F5AB.6030002@asianux.com> <871u6c4yjq.fsf@rustcorp.com.au>
In-Reply-To: <871u6c4yjq.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: James Hogan <james.hogan@imgtec.com>, mmarek@suse.cz, Sam Ravnborg <sam@ravnborg.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 08/02/2013 10:27 AM, Rusty Russell wrote:
> Chen Gang <gang.chen@asianux.com> writes:
>> Need permit '.cranges' section for sh64 architecture, or modpost will
>> report warning:
>>
>>     LD      init/built-in.o
>>   WARNING: init/built-in.o (.cranges): unexpected non-allocatable section.
>>   Did you forget to use "ax"/"aw" in a .S file?
>>   Note that for example <linux/init.h> contains
>>   section definitions for use in .S files.
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> 
> Applied.
> 

Thank you too.

> Thanks,
> Rusty.
> 
>> ---
>>  scripts/mod/modpost.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> index 6216434..8247979 100644
>> --- a/scripts/mod/modpost.c
>> +++ b/scripts/mod/modpost.c
>> @@ -821,6 +821,7 @@ static const char *section_white_list[] >>  {
>>  	".comment*",
>>  	".debug*",
>> +	".cranges",		/* sh64 */
>>  	".zdebug*",		/* Compressed debug sections. */
>>  	".GCC-command-line",	/* mn10300 */
>>  	".GCC.command.line",	/* record-gcc-switches, non mn10300 */
>> -- 
>> 1.7.7.6
> 
> 


-- 
Chen Gang
