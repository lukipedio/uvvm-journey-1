-- -----------------------------------------------------------------------------
-- 'axi4lite_tester' Register Definitions
-- Revision: 4
-- -----------------------------------------------------------------------------
-- Generated on 2021-11-01 at 11:20 (UTC) by airhdl version 2021.10.1-65
-- -----------------------------------------------------------------------------
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
-- -----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package axi4lite_tester_regs_pkg is

    -- Type definitions
    type slv1_array_t is array(natural range <>) of std_logic_vector(0 downto 0);
    type slv2_array_t is array(natural range <>) of std_logic_vector(1 downto 0);
    type slv3_array_t is array(natural range <>) of std_logic_vector(2 downto 0);
    type slv4_array_t is array(natural range <>) of std_logic_vector(3 downto 0);
    type slv5_array_t is array(natural range <>) of std_logic_vector(4 downto 0);
    type slv6_array_t is array(natural range <>) of std_logic_vector(5 downto 0);
    type slv7_array_t is array(natural range <>) of std_logic_vector(6 downto 0);
    type slv8_array_t is array(natural range <>) of std_logic_vector(7 downto 0);
    type slv9_array_t is array(natural range <>) of std_logic_vector(8 downto 0);
    type slv10_array_t is array(natural range <>) of std_logic_vector(9 downto 0);
    type slv11_array_t is array(natural range <>) of std_logic_vector(10 downto 0);
    type slv12_array_t is array(natural range <>) of std_logic_vector(11 downto 0);
    type slv13_array_t is array(natural range <>) of std_logic_vector(12 downto 0);
    type slv14_array_t is array(natural range <>) of std_logic_vector(13 downto 0);
    type slv15_array_t is array(natural range <>) of std_logic_vector(14 downto 0);
    type slv16_array_t is array(natural range <>) of std_logic_vector(15 downto 0);
    type slv17_array_t is array(natural range <>) of std_logic_vector(16 downto 0);
    type slv18_array_t is array(natural range <>) of std_logic_vector(17 downto 0);
    type slv19_array_t is array(natural range <>) of std_logic_vector(18 downto 0);
    type slv20_array_t is array(natural range <>) of std_logic_vector(19 downto 0);
    type slv21_array_t is array(natural range <>) of std_logic_vector(20 downto 0);
    type slv22_array_t is array(natural range <>) of std_logic_vector(21 downto 0);
    type slv23_array_t is array(natural range <>) of std_logic_vector(22 downto 0);
    type slv24_array_t is array(natural range <>) of std_logic_vector(23 downto 0);
    type slv25_array_t is array(natural range <>) of std_logic_vector(24 downto 0);
    type slv26_array_t is array(natural range <>) of std_logic_vector(25 downto 0);
    type slv27_array_t is array(natural range <>) of std_logic_vector(26 downto 0);
    type slv28_array_t is array(natural range <>) of std_logic_vector(27 downto 0);
    type slv29_array_t is array(natural range <>) of std_logic_vector(28 downto 0);
    type slv30_array_t is array(natural range <>) of std_logic_vector(29 downto 0);
    type slv31_array_t is array(natural range <>) of std_logic_vector(30 downto 0);
    type slv32_array_t is array(natural range <>) of std_logic_vector(31 downto 0);

    -- User-logic ports (from user-logic to register file)
    type user2regs_t is record
        dummy : std_logic; -- a dummy element to prevent empty records
    end record;

    -- User-logic ports (from register file to user-logic)
    type regs2user_t is record
        test1_strobe : std_logic; -- Strobe signal for register 'test1' (pulsed when the register is written from the bus}
        test1_value : std_logic_vector(31 downto 0); -- Value of register 'test1', field 'value'
        test2_strobe : std_logic; -- Strobe signal for register 'test2' (pulsed when the register is written from the bus}
        test2_value : std_logic_vector(31 downto 0); -- Value of register 'test2', field 'value'
        test3_strobe : std_logic_vector(0 to 7); -- Strobe signal for register 'test3' (pulsed when the register is written from the bus}
        test3_value : slv32_array_t(0 to 7); -- Value of register 'test3', field 'value'
    end record;

    -- Revision number of the 'axi4lite_tester' register map
    constant AXI4LITE_TESTER_REVISION : natural := 4;

    -- Default base address of the 'axi4lite_tester' register map
    constant AXI4LITE_TESTER_DEFAULT_BASEADDR : unsigned(31 downto 0) := unsigned'(x"10000000");
    -- Size of the 'axi4lite_tester' register map, in bytes
    constant AXI4LITE_TESTER_RANGE_BYTES : natural := 40;

    -- Register 'test1'
    constant TEST1_OFFSET : unsigned(31 downto 0) := unsigned'(x"00000000"); -- address offset of the 'test1' register
    -- Field 'test1.value'
    constant TEST1_VALUE_BIT_OFFSET : natural := 0; -- bit offset of the 'value' field
    constant TEST1_VALUE_BIT_WIDTH : natural := 32; -- bit width of the 'value' field
    constant TEST1_VALUE_RESET : std_logic_vector(31 downto 0) := std_logic_vector'("00000000000000000000000000000000"); -- reset value of the 'value' field

    -- Register 'test2'
    constant TEST2_OFFSET : unsigned(31 downto 0) := unsigned'(x"00000004"); -- address offset of the 'test2' register
    -- Field 'test2.value'
    constant TEST2_VALUE_BIT_OFFSET : natural := 0; -- bit offset of the 'value' field
    constant TEST2_VALUE_BIT_WIDTH : natural := 32; -- bit width of the 'value' field
    constant TEST2_VALUE_RESET : std_logic_vector(31 downto 0) := std_logic_vector'("00000000000000000000000000000000"); -- reset value of the 'value' field

    -- Register 'test3'
    constant TEST3_OFFSET : unsigned(31 downto 0) := unsigned'(x"00000008"); -- address offset of the 'test3' register
    constant TEST3_ARRAY_LENGTH : natural := 8; -- length of the 'test3' register array, in elements
    -- Field 'test3.value'
    constant TEST3_VALUE_BIT_OFFSET : natural := 0; -- bit offset of the 'value' field
    constant TEST3_VALUE_BIT_WIDTH : natural := 32; -- bit width of the 'value' field
    constant TEST3_VALUE_RESET : std_logic_vector(31 downto 0) := std_logic_vector'("00000000000000000000000000000000"); -- reset value of the 'value' field

end axi4lite_tester_regs_pkg;
