using System.Runtime.Serialization;

namespace IBSTestApp.Model
{
    [DataContract]
    public class User
    {
        [DataMember]
        public long UserId { get; set; }
        [DataMember]
        public string Name { get; set; }
    }
}